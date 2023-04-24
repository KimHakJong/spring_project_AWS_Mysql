<!doctype html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <style>
  #draggable { width: 150px; height: 150px; padding: 0.5em; }
  </style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#abc" ).draggable();
  } );
  </script>
</head>
<body>
 
<div id="abc">
  <p>Drag me around</p>
</div>
 
 
</body>
</html>