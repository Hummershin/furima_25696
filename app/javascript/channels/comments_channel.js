import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // alert("connect CommentsChannel")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel


    const html = `
    <div class="comment">
      <div class="user-info">${data.content}</div>
      <p>${data.user_name}</p>
    </div>
    `

    const dom = document.getElementById("comments")
    dom.insertAdjacentHTML( "beforeend", html)
  }
});
