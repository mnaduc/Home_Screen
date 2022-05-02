#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMediaPlayer>
#include <QMediaPlaylist>

#include "App/Media/player.h"
#include "App/Media/playlistmodel.h"
#include "applistmodel.h"
#include "App/Climate/climatemodel.h"
#include "translator.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    qRegisterMetaType<QMediaPlaylist*>("QMediaPlaylist*");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    ClimateModel climateModel;
    engine.rootContext()->setContextProperty("climateModel", &climateModel);

    AppListModel appListModel(QString(PROJECT_PATH) + "applications.xml");
    engine.rootContext()->setContextProperty("appModel", &appListModel);

    Player player;
    engine.rootContext()->setContextProperty("mediaModel", player.playlist_model());
    engine.rootContext()->setContextProperty("player", player.mediaPlayer());
    engine.rootContext()->setContextProperty("utility", &player);

    Translator translator;
    QObject::connect(&translator, &Translator::languageChanged,
                     &engine, &QQmlApplicationEngine::retranslate);
    engine.rootContext()->setContextProperty("Translator", &translator);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
