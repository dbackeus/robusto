Template.meetingsIndex.helpers
  meetings: ->
    Meetings.find()

Template.meetingsIndex.events
  "submit form": (e) ->
    e.preventDefault()
    title = $("[name=meeting-title]").val()
    return alert("title plz!") if title.length == 0
    Meetings.insert title: title
    $("#meeting-title").val("")

  "click .delete-meeting": (e) ->
    Meetings.remove @_id

Template.meetingsShow.helpers
  participations: ->
    Participations.find({meeting_id: @_id})

  participating: ->
    Participations.findOne({meeting_id: @_id, user_id: Meteor.userId()})

Template.meetingsShow.events
  "click #join": (e) ->
    Participations.insert({meeting_id: @_id, user_id: Meteor.userId()})

  "click #reset": (e) ->
    Participations.find(meeting_id: @_id).forEach (participation) ->
      Participations.update(participation._id, $set: {points: null})

Template.participation.helpers
  name: ->
    user = Meteor.users.findOne(@user_id)
    if user
      user.profile.name
    else
      ""

  points: ->
    if @points == 0 || @points
      @points
    else
      "waiting for points"

  fibonacci: ->
    [0,1,2,3,5,8]

  currentUser: ->
    Meteor.userId() == @user_id

Template.participation.events
  "click [data-points]": (e) ->
    $link = $(e.target)
    points = $link.data("points")
    participationId = $link.closest("[data-participation-id]").data("participationId")

    Participations.update({_id: participationId}, $set: {points: points})

  "click #leave": (e) ->
    Participations.remove(@_id)
