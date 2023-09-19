import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['district', 'ward']
  static values = {
    districtId: String,
    url: String
  }

  connect() {
    this.subscribeDistrictChange()
    this.district.select2()
  }

  disconnect() {
    this.ward.select2('destroy');
    this.district.select2('destroy')

  }

  urlValueChanged(value) {
    this.ward.select2({
      dataType: 'json',
      placeholder: {
        id: "-1",
        placeholder: "Select an option"
      },
      ajax: {
        url: `/api/v1/ward/${value}`,
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
  }

  subscribeDistrictChange() {
    let self = this
    this.district.on('select2:select', function (e) {
      var data = e.params.data;
      self.urlValue = data.id
      self.ward.val("").trigger("change")
    });
  }

  get district() {
    return $(this.districtTarget)
  }

  get ward() {
    return $(this.wardTarget)
  }
}
