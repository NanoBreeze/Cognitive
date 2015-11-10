#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDateTime>

#include "pictureurl.h"

int main(int argc, char *argv[])
{


    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    PictureURL pictureUrl;

    engine.rootContext()->setContextProperty("pictureUrl", &pictureUrl);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    //engine.load(QUrl(QStringLiteral("qrc:/MainForm.ui.qml")));

    return app.exec();
}
