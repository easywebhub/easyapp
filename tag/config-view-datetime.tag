<config-view-datetime>
    <div class="field">
        <label>Display name:</label>
        <input type="text" class="form-control" id="textDisplayName" value="{config.displayName}" onkeyup="{edit.bind(this,'config.displayName')}">
    </div>
    <!-- This field is required -->
    <div class="inline field ui checkbox">
        <label class="title">Is required</label>
        <input type="checkbox" onchange="{edit.bind(this,'config.required')}" checked="{config.required}">
    </div>
    <br>
    <!-- View Only Field -->
    <div class="inline field ui checkbox">
        <label class="label">Only View</label>
        <input type="checkbox" onchange="{edit.bind(this,'config.viewOnly')}" checked="{config.viewOnly}">
    </div>

    <!-- DateTime type -->
    <div class="field">
        <label>Display type:</label>
        <select id="dateTimeDisplayType" class="ui dropdown" onchange="{edit.bind(this,'config.displayType')}">
            <option value="Time">Time</option>
            <option value="Date">Date</option>
            <option value="DateTime">DateTime</option>
        </select>
    </div>


    <script>
        var me = this;
        me.mixin('form');

        me.config = {type: 'DateTime'};
        var dateTimeDisplayType;
        me.on('mount', function () {
            dateTimeDisplayType = $(me.root.querySelector('.ui.dropdown'));
            dateTimeDisplayType.dropdown();
        });

        me.clear = function () {
            me.config = {
                type: 'DateTime'
            };
        };

        me.getConfig = function () {
            me.config.type = 'DateTime';
            return me.config;
        };

        me.loadConfig = function (config) {
            me.config = Object.assign({}, config);
            if (me.config.displayType) {
                dateTimeDisplayType.dropdown('set selected', me.config.displayType);
            }


            me.update();
        }
    </script>
</config-view-datetime>
