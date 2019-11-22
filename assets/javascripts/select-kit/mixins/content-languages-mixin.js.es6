import Mixin from "@ember/object/mixin";

export default Mixin.create({
  init() {
    this._super(...arguments);
    this.set("values", this.mutateLanguages(this.get('values')));
  },

  mutateValues(computedValues) {
    this.set("values", this.mutateLanguages(computedValues));
  },
  
  mutateLanguages(values) {
    if (typeof values === 'string') {
      values = [values];
    } else if (Array.isArray(values)) {
      if (values.length === 0) {
        values = ["none"];
      } else {
        values = values.filter(v => v !== 'none');
      }
    } else {
      values = [];
    }
    return values;
  }
});