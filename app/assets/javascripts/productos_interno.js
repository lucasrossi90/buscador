$('document').ready(function(){

  function buildTypeahead(url) {
      // instantiate the bloodhound suggestion engine
      var productos = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('codigo_original', 'codigo_original', 'descripcion'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote: {
              url: url,
              wildcard: '%QUERY',
              limit: 100
          }
      });

      productos.initialize();
      var source = $("#productos-script").html();
      var template = Handlebars.compile(source);
      // instantiate the typeahead UI
      $('#interno').typeahead(null, {
        displayKey: 'productos',
        limit: 100,
        source: productos.ttAdapter(),
        classNames: {
            dataset: 'table',
          },
        templates: {
             empty: [
            '<tr>',
              '<td id=colspan="9">No se pudo encontrar lo buscado</td>',
            '</tr>'
          ].join('\n'),        
              suggestion: template
        }
      });
      
    }

   pagina_actual = 0;
    
   buildTypeahead('/productos/resultado_productos?orden=productos.' + $('#orden').val() + '&interno=%QUERY' + '&page=' + pagina_actual);

   $('#button_edit').click(function(){
      $('<%= render "edit" %>').modal();
   });   
          
   $('#button_anterior').hide();
      
     $('#button_siguiente').click(function(){
      $('#interno').typeahead('destroy');
      pagina_actual = pagina_actual + 1;
      buildTypeahead('/productos/resultado_productos?orden=productos.' + $('#orden').val() + '&interno=%QUERY' + '&page=' + pagina_actual);
      $('#button_anterior').show();
      $('#interno').focus();
    });

      $('#button_anterior').click(function(){
        $('#interno').typeahead('destroy');
        pagina_actual = pagina_actual - 1;
        buildTypeahead('/articulos/resultado_articulos?orden=articulos.' + $('#orden').val() + '&interno=%QUERY' + '&page=' + pagina_actual);
        $('#interno').focus();
        if (pagina_actual == 0){
          $('#button_anterior').hide();
        }
      });

    $('#orden').change(function() {
      $('#interno').typeahead('destroy');
      buildTypeahead('/productos/resultado_productos?orden=productos.' + $(this).val() + '&interno=%QUERY');
      $('#interno').focus();
    });

    $('#rubro').change(function() {
      $('#search').typeahead('destroy');
      buildTypeahead('/productos/resultado_productos?orden=productos.' + $('#orden').val() + '&rubro='+ $(this).val() +
        '&interno=%QUERY');
      $('#interno').focus();
    });

    $('#interno').bind('typeahead:render', function() {
      $('#resultado').html($('.tt-dataset').html());
    });


      // initialize the bloodhound suggestion engine
      

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