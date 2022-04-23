#include "applistmodel.h"
#include <QtXml>
#include <QFile>
#include <QDebug>

AppItem::AppItem(const QString &title, const QString &url, const QString &iconPath) : m_title(title),
    m_url(url),
    m_iconPath(iconPath)
{}

QString AppItem::title() const
{
    return m_title;
}

QString AppItem::url() const
{
    return m_url;
}

QString AppItem::iconPath() const
{
    return m_iconPath;
}

AppListModel::AppListModel(QString filePath, QObject *parent)
{
    Q_UNUSED(parent)
    m_filePath = filePath;
    readXml();
}

void AppListModel::addApp(const AppItem &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << item;
    endInsertRows();
}

int AppListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.count();

}

QVariant AppListModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const AppItem &item = m_data[index.row()];
    if (role == TitleRole)
        return item.title();
    else if (role == UrlRole)
        return item.url();
    else if (role == IconPathRole)
        return item.iconPath();
    return QVariant();
}

QHash<int, QByteArray> AppListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[IconPathRole] = "iconPath";
    return roles;
}

void AppListModel::move(int from, int to)
{
    if(0 <= from && from < m_data.count() && 0 <= to && to < m_data.count() && from != to) {
        if(from < to)
            beginMoveRows(QModelIndex(), from, from, QModelIndex(), to+1);
        else
            beginMoveRows(QModelIndex(), from, from, QModelIndex(), to);
        m_data.move(from, to); // update backing QList
        endMoveRows();
    }
}

void AppListModel::readXml()
{
    // Load xml file as raw data
    QFile f(m_filePath);
    if (!f.open(QIODevice::ReadOnly ))
    {
        // Error while loading file
        qDebug() << "readXml: error";
        return;
    }
    // Set data into the QDomDocument before processing
    QDomDocument doc;
    doc.setContent(&f);
    f.close();

    //Paser xml
    QDomElement root = doc.documentElement();
    // Get the first child of the root (Markup COMPONENT is expected)
    QDomElement component=root.firstChild().toElement();
    while (!component.isNull()) {
        if(component.tagName() == "APP") {
            QString title = "";
            QString url = "";
            QString iconPath = "";
            QDomElement child = component.firstChild().toElement();
            while (!child.isNull()) {
                if(child.tagName() == "TITLE") title = child.firstChild().toText().data();
                if(child.tagName() == "URL") url = child.firstChild().toText().data();
                if(child.tagName() == "ICON_PATH") iconPath = child.firstChild().toText().data();
                child = child.nextSibling().toElement();
            }
            AppItem item(title, url, iconPath);
            addApp(item);
        }
        // Next component
        component = component.nextSibling().toElement();
    }
}

void AppListModel::writeXml()
{
    QDomDocument doc;
    QDomElement apps = doc.createElement("APPLICATIONS");
    doc.appendChild(apps);
    for (int i = 0; i < m_data.count(); ++i) {
        QDomElement app = doc.createElement("APP");
        app.setAttribute("ID", i);
        AppItem item = m_data.at(i);

        // title
        QDomElement title = doc.createElement("TITLE");
        title.appendChild(doc.createTextNode(item.title()));
        app.appendChild(title);
        // url
        QDomElement url = doc.createElement("URL");
        url.appendChild(doc.createTextNode(item.url()));
        app.appendChild(url);
        // icon_path
        QDomElement iconPath = doc.createElement("ICON_PATH");
        iconPath.appendChild(doc.createTextNode(item.iconPath()));
        app.appendChild(iconPath);

        apps.appendChild(app);
    }

    //Write to file
    QFile f(m_filePath);
    if(!f.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << "writeXml: error";
        return;
    }
    else
    {
        QTextStream stream(&f);
        stream << doc.toString();
        f.close();
    }
}
