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
  $("#links-list").append( linkHTML(link) )
  clearLink();
  attachReadEvent(link);
}

function attachReadEvent(link){
  if (link.read === false) {
    markReadEvent
  } else {
    markUneadEvent
  }
}

function markReadEvent(){
  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    });
  })
}

function markUneadEvent(){

}

function linkHTML(link) {
    if (link.read === false){
    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title'>${ link.title }</p>
              <p class='link-url'>${ link.url }</p>

              <p class="link_read">
                ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="read-button" data-id='${link.id}'>Mark as Read</button>
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
              <button class="read-button" data-id='${link.id}'>Mark as Read</button>
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
