#ifndef PICTUREURL_H
#define PICTUREURL_H

#include <QObject>
#include <QString>
#include <qglobal.h>
#include <QException>
#include <QDateTime>

#include "pictureenumeration.h"

class PictureURL : public QObject
{
    Q_OBJECT
public:
    explicit PictureURL(QObject *parent = 0);
    Q_INVOKABLE QString select_picture_URL();
    Q_INVOKABLE bool is_same_pictures();


private:
    const int total_number_of_image = 3;
    PictureEnumeration Select_enum_for_picture();
    QString Find_URL(PictureEnumeration pictureNumber);
    void Set_Picture_Order(PictureEnumeration pictureNumber);
    PictureEnumeration picture1 ;
    PictureEnumeration picture2 ;



signals:

public slots:
};

#endif // PICTUREURL_H
