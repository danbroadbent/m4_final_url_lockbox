var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
  displayExistingLinks()
  $newLinkTitle = $("#link-title");
  $newLinkUrl  = $("#link-url");

  $("#new-link").on('submit', createLink);
})

function displayExistingLinks(){
  $.get("api/v1/links")
  .then(function(links){
    links.forEach(renderLink)
  })
}

function createLink (event){
  event.preventDefault();

  console.log("win")

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $("#links-list").prepend( linkHTML(link) )
  clearLink();
  attachReadEvent(link);
}

function attachReadEvent(link){
  if (link.read === false) {
    markReadEvent(link.id)
  } else {
    markUnreadEvent(link.id)
  }
}

function markReadEvent(id){
  $(`#link-${id} .read-button`).on('click', markRead)
}

function markRead() {
  var readLink = $(this).data("url")
  var id = $(this).data("id")
  $.ajax( {
    method: 'PATCH',
    data: {read: true},
    url: `api/v1/links/${id}`
  })
  .then($(`#link-${id} .read-button`).text('Mark as Unread'))
  .then($(`#link-${id} .link_read`).text('Read? true'))
  .then($(`#link-${id}`).addClass('read'))
  .then(markUnreadEvent(id))
  .then($.ajax( {
    method: 'POST',
    data: {url: readLink},
    url: "https://db-mod4finalservice.herokuapp.com/api/v1/reads"
  }))
}

function markUnreadEvent(id){
  $(`#link-${id} .read-button`).on('click', markUnread)
}

function markUnread(){
  var readLink = $(this).data("url")
  var id = $(this).data("id")
  $.ajax( {
    method: 'PATCH',
    data: {read: false},
    url: `api/v1/links/${id}`
  })
  .then($(`#link-${id} .read-button`).text('Mark as Read'))
  .then($(`#link-${id} .link_read`).text('Read? false'))
  .then($(`#link-${id}`).removeClass('read'))
  .then(markReadEvent(id))
}

function linkHTML(link) {
    if (link.read === false){
    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title'>Title: ${ link.title }</p>
              <p class='link-url'>URL: ${ link.url }</p>

              <p class="link_read">
                Read? ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="read-button" data-id='${link.id}' data-url='${link.url}'>Mark as Read</button>
                <a href='/links/${link.id}/edit'>Edit</a>
                <button class='delete-link'>Delete</button>
              </p>
            </div>`
    } else {
    return `<div class='link read' data-id='${link.id}' id="link-${link.id}">
            <p class='link-title'>${ link.title }</p>
            <p class='link-url'>${ link.url }</p>

            <p class="link_read">
              ${ link.read }
            </p>
            <p class="link_buttons">
              <button class="read-button" data-id='${link.id}' data-url='${link.url}'>Mark as Unread</button>
              <a href='/links/${link.id}/edit'>Edit</a>
              <button class='delete-link'>Delete</button>
            </p>
          </div>`
      }
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  $('#link-errors').append(`<p>FAILED attempt to create new Link: ${failureData.responseText}</p>`);
}
