#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
#include "climate_interface.h"

class ClimateModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double driver_temp READ GetDriverTemperature NOTIFY dataChanged)
    Q_PROPERTY(double passenger_temp READ GetPassengerTemperature NOTIFY dataChanged)
    Q_PROPERTY(int driver_wind_mode READ GetDriverWindMode NOTIFY dataChanged)
    Q_PROPERTY(int passenger_wind_mode READ GetPassengerWindMode NOTIFY dataChanged)
    Q_PROPERTY(int fan_level READ GetFanLevel NOTIFY dataChanged)
    Q_PROPERTY(int auto_mode READ GetAutoMode NOTIFY dataChanged)
    Q_PROPERTY(int sync_mode READ GetSyncMode NOTIFY dataChanged)
private:
    local::Climate *m_data;
    double GetDriverTemperature() const;
    double GetPassengerTemperature() const;
    int GetDriverWindMode() const;
    int GetPassengerWindMode() const;
    int GetFanLevel() const;
    int GetAutoMode() const;
    int GetSyncMode() const;
public:
    explicit ClimateModel(QObject *parent = nullptr);
signals:
    void dataChanged();
};

#endif // CLIMATEMODEL_H
