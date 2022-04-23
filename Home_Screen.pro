QT += quick core multimedia xml dbus

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
DEFINES += PROJECT_PATH=\"\\\"$${_PRO_FILE_PWD_}/\\\"\"

DBUS_INTERFACES += climate.xml

SOURCES += \
        App/Climate/climatemodel.cpp \
        App/Media/player.cpp \
        App/Media/playlistmodel.cpp \
        applistmodel.cpp \
        main.cpp

RESOURCES += qml.qrc \
    resource.qrc

INCLUDEPATH += $$PWD/App/Media/MyTagLib/include

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
win32 {
    LIBS += -L$$PWD/App/Media/MyTagLib/windows -lMyTagLib
}

linux {
    LIBS += -L$$PWD/App/Media/MyTagLib/ubuntu -lMyTagLib
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    App/Climate/climatemodel.h \
    App/Media/player.h \
    App/Media/playlistmodel.h \
    applistmodel.h
DISTFILES += \
    applications.xml

STATECHARTS +=
