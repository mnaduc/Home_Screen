#ifndef APPLISTMODEL_H
#define APPLISTMODEL_H

#include <QAbstractListModel>

class AppItem {
public:
    AppItem(const QString &title, const QString &url, const QString &iconPath);
    QString title() const;
    QString url() const;
    QString iconPath() const;
private:
    QString m_title;
    QString m_url;
    QString m_iconPath;

};

class AppListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        UrlRole,
        IconPathRole
    };
    AppListModel(QString filePath, QObject *parent = nullptr);
    void addApp(const AppItem &item);

    // QAbstractItemModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE void move(int from, int to);
private:
    QList<AppItem> m_data;
    QString m_filePath;
    void readXml();
public slots:
    void writeXml();
};

#endif // APPLISTMODEL_H
