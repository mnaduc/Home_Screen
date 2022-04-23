#include "climatemodel.h"
#include <QDBusConnection>
#include <QDebug>

ClimateModel::ClimateModel(QObject *parent)
    : QObject{parent}
{
    m_data = new local::Climate("mnaduc.gmail.com","/Climate",QDBusConnection::sessionBus(),this);
    if(!m_data->isValid())
    {
        qDebug() << "Can not connect!";
    }
    else
    {
        qDebug() << "Connect success!";
        QObject::connect(m_data, &local::Climate::dataChanged, this, &ClimateModel::dataChanged);
    }
}

double ClimateModel::GetDriverTemperature() const
{
    return m_data->getTemp_driver();
}

double ClimateModel::GetPassengerTemperature() const
{
    return m_data->getTemp_passenger();
}

int ClimateModel::GetDriverWindMode() const
{
    return m_data->getDriverWind_mode();
}

int ClimateModel::GetPassengerWindMode() const
{
    return m_data->getPassengerWind_mode();
}

int ClimateModel::GetFanLevel() const
{
    return m_data->getFan_speed();
}

int ClimateModel::GetAutoMode() const
{
    return m_data->getAuto_mode();
}

int ClimateModel::GetSyncMode() const
{
    return m_data->getSync_mode();
}
