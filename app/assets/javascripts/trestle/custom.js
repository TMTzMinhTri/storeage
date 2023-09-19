// This file may be used for providing additional customizations to the Trestle
// admin. It will be automatically included within all admin pages.
//
// For organizational purposes, you may wish to define your customizations
// within individual partials and `require` them here.
//
//  e.g. //= require "trestle/custom/my_custom_js"
$(function () {
  const districtEl = $("#borrower_district_id")
  const wardEl = $("#borrower_ward_id")

  districtEl.on('select2:select', function (e) {
    const data = e.params.data;
    currnetId = data.id

    wardEl.val("").trigger("change")

    wardEl.select2({
      dataType: 'json',
      placeholder: {
        id: "-1",
        placeholder: "Select an option"
      },
      ajax: {
        url: `/api/v1/ward/${data.id}`,
        delay: 250,
        processResults: function (data, params) {
          return {
            results: [...$.map(data, function (value, index) {
              return { id: value.id, text: value.name };
            })]
          };
        }
      }
    })
  });
});