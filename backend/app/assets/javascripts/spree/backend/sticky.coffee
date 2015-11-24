$.fn.offsetBottom = ->
  $(this).offset().top + $(this).height()

class Viewport
  measure: =>
    @top = document.documentElement.scrollTop || document.body.scrollTop
    @height = $(window).height()
    @bottom = @top + @height

  isScrollingUp: =>
    @measure()
    goingUp = @top < @lastTop
    @lastTop = @top
    goingUp

  isAbove: (el) =>
    @top < el.offset().top

  isBelow: (el) =>
    @bottom > el.offsetBottom()

  fits: (el) =>
    el.height() < @height

viewport = new Viewport()

$(window).on
  resize: _.debounce(viewport.measure, 100)

class Sticky
  @checkStickies: =>
    for sticky in @stickies
      sticky.measure()
      if viewport.isScrollingUp()
        if sticky.isStuckBottom
          sticky.pin()
        else
          sticky.stick() if viewport.isAbove(sticky.el)
        if sticky.tooHigh()
          sticky.unstick() if sticky.isStuckTop
      else
        if viewport.fits(sticky.el)
          sticky.stick() unless viewport.isAbove(sticky.el)
        else
          sticky.stick(true) if viewport.isBelow(sticky.el)
          if sticky.tooLow()
            sticky.pin(true)

  @stickies: []

  constructor: (@el) ->
    @container = @el.parent()
    @placeholder = $('<div>').insertBefore(@el)
    @measure()
    if @container.css('position') == 'static'
      @container.css('position', 'relative')
    Sticky.stickies.push(this)

  measure: =>
    @maxTop = @placeholder.offset().top
    @maxBottom = @container.offsetBottom()

  tooLow: =>
    @el.offsetBottom() >= @maxBottom

  tooHigh: =>
    @el.offset().top <= @maxTop

  stick: (bottom) =>
    if bottom
      return if @isStuckBottom
      @isStuckBottom = true
    else
      return if @isStuckTop
      @isStuckTop = true
    width = @el.width()
    @el.addClass(if bottom then 'sticky-bottom' else 'sticky-top')
      .css
        position: 'fixed'
        top: ''
        width: width

  unstick: =>
    return unless @isStuckBottom || @isStuckTop
    @isStuckBottom = @isStuckTop = false
    @el.removeClass('sticky-bottom sticky-top')
    @el.css('position', '')

  pin: (bottom) =>
    top = @el.offset().top - @container.offset().top
    @unstick()
    @el.css('position', 'absolute')
    if bottom
      @el.css('bottom', 0)
    else
      @el.css('top', Math.max(top, @maxTop))

  $(window).on
    scroll: @checkStickies

$.fn.sticky = ->
  $(this).each ->
    new Sticky($(this))

$ ->
  $('[data-sticky]').sticky()
