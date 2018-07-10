// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery/dist/jquery
//= require highcharts/highmaps.js
//= require highcharts/customworld.js
//= require_tree .


$.getJSON('https://cdn.rawgit.com/highcharts/highcharts/680f5d50a47e90f53d814b53f80ce1850b9060c0/samples/data/world-population-density.json', function(data) {
  $.each(data, function() {
    this.value = (this.value < 1 ? 1 : this.value);

  });


  // Initiate the chart
  Highcharts.mapChart('map-container', {
    chart: {
      map: 'custom/world',
      backgroundColor: '#121314',
      height: '55%',
    },

    title: {
      text: ' '
    },

    mapNavigation: {
      enabled: true,
      enableDoubleClickZoomTo: true
    },

    colorAxis: {
      min: 1,
      max: 1000,
      type: 'logarithmic'
    },

    plotOptions: {
      series: {
        point: {
          events: {
            click: function() {
              console.log(this.name)
              $('.genres').empty()
              $.ajax({
                url: "/country",
                dataType: 'json',
                data: {
                  country: this.name
                },
                success: function(response) {
                  console.log(response);
                  if (response.success) {
                    $('iframe').attr('src', response.uri)
                  } else {
                    let genreCard = $(`<li class='genre-card'><img class="icon-xsm px-4" src="assets/gen-icon.png">${response.message}</li>`)
                    $('.genres').append(genreCard)
                  }

                },
              })
              $.ajax({
                url: "/genres",
                dataType: 'json',
                data: {
                  country: this.name
                },
                success: function(countryGenre) {

                  for (let i = 0; i < countryGenre.length; i++) {

                    let genreCard = $(`<li class='genre-card' data-genre-name='${countryGenre[i].name}'><img class="icon-xsm px-4" src="assets/${countryGenre[i].icon}-icon.png"><span>${toTitleCase(countryGenre[i].name)}</span></li>`)
                    $('.genres').append(genreCard)
                  }
                  $('.genres').click(function(event) {
                    console.log(event);
                    let targetLi = null
                    if ($(event.target).is('li')) {
                      targetLi = $(event.target);
                    } else {
                      targetLi = $(event.target.parentElement);
                    }
                    $('.genres > li').removeClass('active')
                    targetLi.addClass('active')
                    console.log(targetLi.attr('data-genre-name'))
                    let genreName = targetLi.attr('data-genre-name');
                    $.ajax({
                      url: "/play-genre",
                      dataType: 'json',
                      data: {
                        genre: genreName
                      },
                      success: function(genre) {
                        $('iframe').attr('src', genre.uri)
                      }
                    });
                  })
                }
              })
            }
          }
        }
      }
    },
    series: [{
      data: data,
      joinBy: ['iso-a3', 'code3'],
      name: 'Population density',
      states: {
        hover: {
          color: 'yellow'
        }
      },
      tooltip: {
        valueSuffix: '/km²'
      }
    }],

  });
});

function toTitleCase(str) {
  return str.replace(/\w\S*/g, function(txt) {
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
}