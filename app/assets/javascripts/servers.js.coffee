//= require admin/jquery.dataTables.min
//= require admin/dataTables.bootstrap
//= require admin/dataTables.bootstrapPagination
//= require admin/dataTables.colVis.min
//= require admin/jquery-ui-1.10.4.custom.min
//= require admin/bootstrap-switch.min

`
$(function(){
  $('.switch_checkbox').bootstrapSwitch({
      'size' : 'mini',
      'onText' : '<em class="fa fa-star"></em>',
      'offText' : '<em class="fa fa-star-o"></em>',
      'onColor' : 'default',
      'onSwitchChange' : function(event, state) {
          var id = $(this).parents('.panel')[0].id;
          if (state == true) {
            $.ajax({ type:'POST',url:'/dashboard_portlets',data:{id:id} });
          } else {
            $.ajax({ type:'POST',url:'/dashboard_portlets/delete',data:{id:id} });
          }
      }
  });
});

/**=========================================================
 * Module: portlet.js
 * Drag and drop any panel to change its position
 * The Selector should could be applied to any object that contains
 * panel, so .col-* element are ideal.
 =========================================================*/

(function($, window, document){
  'use strict';

  // Component is required
  if(!$.fn.sortable) return;

  var Selector = '[data-toggle="portlet"]',
      storageKeyName = 'portletState';

  $(function(){

    $( Selector ).sortable({
      connectWith:          Selector,
      items:                'div.panel',
      handle:               '.portlet-handler',
      opacity:              0.7,
      placeholder:          'portlet box-placeholder',
      cancel:               '.portlet-cancel',
      forcePlaceholderSize: true,
      iframeFix:            false,
      tolerance:            'pointer',
      helper:               'original',
      revert:               200,
      forceHelperSize:      true,
      start:                saveListSize,
      // stop:                 savePortletOrder ONLY GETS SELECTED COLUMN
      update:               savePortletOrder
      //create:               loadPortletOrder
    })
    // optionally disables mouse selection
    //.disableSelection()
    ;

  });

  function savePortletOrder(event, ui) {

    //var data = store.get(storageKeyName);

    //if(!data) { data = {}; }
    var data = {};
    data[this.id] = $(this).sortable('toArray');

    //if(data) {
    //  store.set(storageKeyName, data);
    //}

    // save portlet size to avoid jumps
    // saveListSize.apply(this);

    var request = $.ajax({
      type: 'POST',
      url:  '/portlets/reorder',
      data: data
    });

    request.fail(function(resp){
      // TODO: set error notification
    });
  }

  function loadPortletOrder() {

    var data = store.get(storageKeyName);

    if(data) {

      var porletId = this.id,
          panels   = data[porletId];

      if(panels) {
        var portlet = $('#'+porletId);

        $.each(panels, function(index, value) {
           $('#'+value).appendTo(portlet);
        });
      }

    }

    // save portlet size to avoid jumps
    saveListSize.apply(this);
  }

  // Keeps a consistent size in all portlet lists
  function saveListSize() {
    var $this = $(this);
    $this.css('min-height', $this.height());
  }

  /*function resetListSize() {
    $(this).css('min-height', "");
  }*/

}(jQuery, window, document));
`
