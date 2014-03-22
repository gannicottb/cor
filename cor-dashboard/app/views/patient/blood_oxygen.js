var threshold = 90;
var dataHash = [
                    [Date.UTC(1970,  9, 27), 90   ],
                    [Date.UTC(1970, 10, 10), 80.6 ],
                    [Date.UTC(1970, 10, 18), 90.7 ],
                    [Date.UTC(1970, 11,  2), 80.8 ],
                    [Date.UTC(1970, 11,  9), 90.6 ],
                    [Date.UTC(1970, 11, 16), 90.6 ],
                    [Date.UTC(1970, 11, 28), 90.67],
                    [Date.UTC(1971,  0,  1), 90.81],
                    [Date.UTC(1971,  0,  8), 90.78],
                    [Date.UTC(1971,  0, 12), 90.98],
                    [Date.UTC(1971,  0, 27), 91.84],
                    [Date.UTC(1971,  1, 10), 91.80],
                    [Date.UTC(1971,  1, 18), 91.80],
                    [Date.UTC(1971,  1, 24), 91.92],
                    [Date.UTC(1971,  2,  4), 92.49],
                    [Date.UTC(1971,  2, 11), 92.79],
                    [Date.UTC(1971,  2, 15), 92.73],
                    [Date.UTC(1971,  2, 25), 92.61],
                    [Date.UTC(1971,  3,  2), 92.76],
                    [Date.UTC(1971,  3,  6), 92.82],
                    [Date.UTC(1971,  3, 13), 92.8 ],
                    [Date.UTC(1971,  4,  3), 92.1 ],
                    [Date.UTC(1971,  4, 26), 81.1 ],
                    [Date.UTC(1971,  5,  9), 90.25],
                    [Date.UTC(1971,  5, 12), 80   ]
                ]; /* must be sorted */

$(function () {
        $('#blood_oxygen_container').highcharts({
            chart: {
                type: 'spline'
            },
            title: {
                text: 'Blood Oxygen'
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
                    text: 'Blood Oxygen (%)'
                },
                plotBands: [{
                    from: 0,
                    to: threshold,
                    color: 'rgba(255, 0, 0, .6)',
                    label: {
                        text: 'Normal',
                        style: {
                            color: '#606060'
                        }
                    }
                }, { 
                    from: threshold,
                    to: 100,
                    color: 'rgba(0, 255, 0, .3)',
                    label: {
                        text: 'Below normal',
                        style: {
                            color: '#606060'
                        }
                    }
                }],
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
                name: 'Blood Oxygen',
                // Define the data points. All series have a dummy year
                // of 1970/71 in order to be compared on the same x axis. Note
                // that in JavaScript, months start at 0 for January, 1 for February etc.
                data: dataHash
            }]
        });
    });