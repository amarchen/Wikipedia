
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>

#include <sailfishapp/sailfishapp.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
//    QGuiApplication* app = SailfishApp::application(argc, argv);
//    QQuickView* view = SailfishApp::createView();
//    view->engine()->addImportPath(SailfishApp::pathTo("qml/components").toString());
//    view->setSource(SailfishApp::pathTo("qml/sailImportPathTrial.qml"));
//    view->show();

//    int res = app->exec();
//    delete app;
//    return res;
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->engine()->addImportPath(SailfishApp::pathTo("components/Mixpanel/src").toString());
    view->setSource(SailfishApp::pathTo("main.qml"));
    
    view->show();
    
    return app->exec();
}


