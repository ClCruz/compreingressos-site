// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Initialize Firebase
var config = {
  apiKey: "AIzaSyAk6Hy_l_nuUVDJhHGX-jz8b2aV9mhoCXw",
  authDomain: "compreingressos-61e03.firebaseapp.com",
  databaseURL: "https://compreingressos-61e03.firebaseio.com",
  projectId: "compreingressos-61e03",
  storageBucket: "compreingressos-61e03.appspot.com",
  messagingSenderId: "941400984856"
};
firebase.initializeApp(config);

var messaging = firebase.messaging();
messaging.requestPermission()
.then(function() {
  console.log("All allowed");
  // Retrieve an Instance ID token for use with FCM
  return messaging.getToken();
})
.then(function(token) {
  console.log(token);
})
.catch(function(err) {
  console.log(err);
});

messaging.onMessage(function(payload) {
  console.log('onMessage event: ', payload);
});