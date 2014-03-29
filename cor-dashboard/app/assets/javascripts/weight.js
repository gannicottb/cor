var regData = new Array();
var irregData = new Array();

var irregularity = new Array();
for(var i=0; i<data.length; i++) {
    irregularity[i] = false;
}

for(var i=0; i<data.length; i++) {
    var prevIdx = (i - timeThreshold > 0) ? i - timeThreshold  : 0;
    var delta = data[i] - data[prevIdx];
    if(delta >= weightThreshold) {
        for(var j=0; j<timeThreshold; j++){
            irregularity[i-j] = true;
        }
    }
}

for(var i=0; i<irregularity.length; i++) {
    if(irregularity[i]) {
        regData[i] = null;
        irregData[i] = data[i];
    } else {
        regData[i] = data[i];
        irregData[i] = null;
    }
}

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
                text: 'Weight (pounds)'
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+
                    Highcharts.dateFormat('%b %e', this.x) +': '+ this.y +' %';
            }
        },

        series: [{
                name: 'Regular',
                color: '#00FF00',
                data:regData
            }, {
                name: 'Irregular',
                color: '#FF0000',
                lineWidth: 5,
                data:irregData
            }]
    });
});
    
