function populate_sodium_container() {
    console.log(data);
    $('#sodium_container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Sodium'
        },
        subtitle: {
            text: ''
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
                text: 'Sodium Intake'
            },            
            min: 0,
            max: 4
        },
        tooltip: {
            formatter: function() {
                switch(this.y)
                {
                case 1:
                    return '<b>'+ this.series.name +'</b><br/>'+
                            Highcharts.dateFormat('%b %e', this.x) +': '+ 'Low';
                case 2:
                    return '<b>'+ this.series.name +'</b><br/>'+
                            Highcharts.dateFormat('%b %e', this.x) +': '+ 'Medium';
                case 3:
                    return '<b>'+ this.series.name +'</b><br/>'+
                            Highcharts.dateFormat('%b %e', this.x) +': '+ 'High';
                default:
                    return "Value not 1, 2, or 3, like it's supposed to be";
                }

            }
        },

        series: [{
            name: 'Reported Sodium Intake',
            // Define the data points. All series have a dummy year
            // of 1970/71 in order to be compared on the same x axis. Note
            // that in JavaScript, months start at 0 for January, 1 for February etc.
            data:data
        }]
    });
}

