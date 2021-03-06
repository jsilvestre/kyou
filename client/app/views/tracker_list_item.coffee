BaseView = require 'lib/base_view'
request = require 'lib/request'
graph = require 'lib/graph'

# Item View for the albums list
module.exports = class TrackerItem extends BaseView
    className: 'tracker line'
    template: require 'views/templates/tracker_list_item'

    events:
        'click .remove-btn': 'onRemoveClicked'
        'click .up-btn': 'onUpClicked'
        'click .down-btn': 'onDownClicked'
        'keyup .tracker-increment': 'onCurrentAmountKeyup'

    onRemoveClicked: =>
        answer = confirm "Are you sure that you want to delete this tracker?"
        if answer
            @model.destroy
                success: =>
                    @remove()
                error: ->
                    alert 'something went wrong while removing tracker.'

    afterRender: (callback) =>
        day = window.app.mainView.currentDate
        getData = =>
            @model.getDay day, (err, amount) =>
                if err
                    alert "An error occured while retrieving tracker data"
                else if not amount?
                    @$('.current-amount').html(
                        'Set value for current day')
                else
                    @$('.current-amount').html amount.get 'amount'

                @getAnalytics callback

        if @model.id?
            getData()
        else
            setTimeout getData, 1000

    onCurrentAmountKeyup: (event) ->
        keyCode = event.which or event.keyCode
        @onUpClicked() if keyCode is 13

    onUpClicked: (event) ->
        day = window.app.mainView.currentDate
        @model.getDay day, (err, amount) =>
            if err
                alert 'An error occured while retrieving data'
                return
            else if amount? and amount.get('amount')?
                amount = amount.get 'amount'
            else
                amount = 0

            try
                amount += parseInt @$('.tracker-increment').val()
            catch
                return false

            label = @$('.current-amount')
            label.css 'color', 'transparent'
            label.spin 'tiny', color: '#444'
            day = window.app.mainView.currentDate
            @model.updateDay day, amount, (err) =>
                label.spin()
                label.css 'color', '#444'
                if err
                    alert 'An error occured while saving data'
                else
                    label.html amount
                    @data[@data.length - 1]['y'] = amount
                    @$('.chart').html null
                    @$('.y-axis').html null
                    @redrawGraph()


    onDownClicked: (event) ->
        day = window.app.mainView.currentDate
        @model.getDay day, (err, amount) =>
            if err then alert 'An error occured while retrieving data'
            if amount? and amount.get('amount')?
                amount = amount.get 'amount'
            else
                amount = 0

            try
                amount -= parseInt @$('.tracker-increment').val()
                amount = 0 if amount < 0
            catch
                return false

            label = @$('.current-amount')
            label.css 'color', 'transparent'
            label.spin 'tiny', color: '#444'
            day = window.app.mainView.currentDate
            @model.updateDay day, amount, (err) =>
                label.spin()
                label.css 'color', '#444'
                if err
                    alert 'An error occured while saving data'
                else
                    label.html amount
                    @data[@data.length - 1]['y'] = amount
                    @$('.chart').html null
                    @$('.y-axis').html null
                    @redrawGraph()


    getAnalytics: (callback) ->
        @$(".graph-container").spin 'tiny'
        day = window.app.mainView.currentDate.format "YYYY-MM-DD"
        request.get "trackers/#{@model.get 'id'}/amounts/#{day}", (err, data) =>
            if err
                alert "An error occured while retrieving data"
            else
                @$(".graph-container").spin()
                @data = data
                @drawCharts()
                callback() if callback?

    redrawGraph: ->
        @drawCharts()

    drawCharts: ->
        width = @$(".graph-container").width() - 70
        el = @$('.chart')[0]
        yEl = @$('.y-axis')[0]
        color = 'black'

        graph.draw el, yEl, width, color, @data
