#include "pictureurl.h"

PictureURL::PictureURL(QObject *parent) : QObject(parent),
    picture1(PictureEnumeration::NULL_PICTURE), picture2(PictureEnumeration::NULL_PICTURE)
{
    qsrand(QDateTime::currentMSecsSinceEpoch());
}

//returns a the URL of a randomly selected picture
QString PictureURL::select_picture_URL()
{
    PictureEnumeration pictureNumber = Select_enum_for_picture();
    Set_Picture_Order(pictureNumber);
    return Find_URL(pictureNumber);
}

bool PictureURL::is_same_pictures()
{
    return (picture1 == picture2) ? true : false;
}

//================================== //
//======== HELPER FUNCTIONS ======== //
//================================== //


//Creates a random number that will later be used to identify a picture
PictureEnumeration PictureURL::Select_enum_for_picture()
{
    return static_cast<PictureEnumeration>(qrand()%total_number_of_image);
}


//URL of pictures are associated with a numbers. Returns the associated URL
QString PictureURL::Find_URL(PictureEnumeration pictureNumber)
{
    QString url;
    switch(pictureNumber)
    {
    case PictureEnumeration::Picture0 :
        url = "///beautifulSunset.jpeg";
        break;
    case PictureEnumeration::Picture1:
        url = "///beautifulEvening.jpeg";
        break;
    case PictureEnumeration::Picture2:
        url = "///beautifulIsland.jpeg";
        break;
    default:
        throw QException::exception();
    }
    return url;
}

void PictureURL::Set_Picture_Order(PictureEnumeration pictureNumber)
{
    if (picture1 == PictureEnumeration::NULL_PICTURE) { picture1 = pictureNumber; }
    else if (picture2 == PictureEnumeration::NULL_PICTURE) {picture2 = pictureNumber; }
        // since both picture1 and picture2 have values, there are already two pictures.
        // Thus, we set picture1's enum to be equal to picture2's enum and picture2's enum to the enum associated with the new picture2, which is passed in as pictureNumber
     else
    {
        picture1 = picture2;
        picture2 = pictureNumber;
    }
}
