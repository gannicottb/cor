$(function () {
        $('#weight_container').highcharts({
            chart: {
                type: 'spline'
            },
            title: {
                text: 'Weight'
            },
            subtitle: {
                text: 'Irregular time data in Highcharts JS'
            },
            xAxis: {
                type: 'datetime',
                dateTimeLabelFormats: { // don't display the dummy year
                    month: '%b %e',
                    year: '%b'
                }
            },
            yAxis: {
                title: {
                    text: 'Weight Change (lbs)'
                },                
                min: 0,
                max: 100
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%b %e', this.x) +': '+ this.y +' %';
                }
            },
            
            series: [{
                name: 'Weight',
                // Define the data points. All series have a dummy year
                // of 1970/71 in order to be compared on the same x axis. Note
                // that in JavaScript, months start at 0 for January, 1 for February etc.
                data: data
            }]
        });
    });
    
