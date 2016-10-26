$('document').ready(function(){

    function buildTypeahead(url) {
      // instantiate the bloodhound suggestion engine
      var articulos = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('codigo', 'descripcion'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote: {
              url: url,
              wildcard: '%QUERY',
              limit: 100
          }
      });
      // initialize the bloodhound suggestion engine
      articulos.initialize();
      var source = $("#articulos-script").html();
      var template = Handlebars.compile(source);

      // instantiate the typeahead UI
      $('#search').typeahead(null, {
        displayKey: 'articulos',
        limit: 100,
        source: articulos.ttAdapter(),
        classNames: {
            dataset: 'table',
          },
        templates: {
             empty: [
            '<tr>',
              '<td colspan="9">No se pudo encontrar lo buscado</td>',
            '</tr>'
          ].join('\n'),        
              suggestion: template
        }
      });
    }
    
    buildTypeahead('/articulos/resultado_articulos?search=%QUERY');

    $('#proveedor').change(function() {
      $('#search').typeahead('destroy');
      buildTypeahead('/articulos/resultado_articulos?proveedor='+ $(this).val() +'&search=%QUERY');
      $('#search').focus();
    });


    $('#search').bind('typeahead:render', function() {
      $('#resultado').html($('.tt-dataset').html());
    });

    // function actualizarResultados() {
    //   $.get('/articulos/resultado_articulos', { search: $('#search').val() })
    //   .success(function(response){
    //     $('#resultado').html(response);
    //   });
    // }

    // $("#search").keyup(function(event){
    // if (event.which === 13) {
    //    actualizarResultados();
    //   }
    // });

    // $("#botonBusqueda").click(actualizarResultados());

    // $('#proveedor').change(function() {
    //   actualizarResultados();
    // });

    // actualizarResultados();
    // $('#search').keyup(function() {
    //   actualizarResultados();
    // });    
});