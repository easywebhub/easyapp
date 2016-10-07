<config-view-boolean>
    <div class="field">
        <label>Display name:</label>
        <input type="text"id="textDisplayName" value="{config.displayName}" onkeyup="{edit('config.displayName')}">
    </div>
    <!-- This field is required -->
    <div class="inline field ui checkbox">
        <label class="title">Is required</label>
        <input type="checkbox" onchange="{edit('config.required')}" checked="{config.required}">
    </div>
    <br>
    <!-- View Only Field -->
    <div class="inline field ui checkbox">
        <label class="label">Only View</label>
        <input type="checkbox" onchange="{edit('config.viewOnly')}" checked="{config.viewOnly}">
    </div>

    <script>
        var me = this;
        me.mixin('form');

        me.config = { type: 'Boolean' };

        me.clear = function () {
            me.config = {
                type: 'Boolean'
            };
        };

        me.getConfig = function () {
            me.config.type = 'Boolean';
            return me.config;
        };

        me.loadConfig = function(config) {
            me.config = Object.assign({}, config);
            me.update();
        }
    </script>
</config-view-boolean>
