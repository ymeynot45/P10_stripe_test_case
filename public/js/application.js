$(document).ready(function(){
    var player1 = new Player($('#player1').text());
    var player2 = new Player($('#player2').text());
    debugger;
  $(document).bind('keyup', function(keystroke){
    
    var current_position_1 = $("#player1_strip > .active");
    var current_position_2 = $("#player2_strip > .active");

    var url = "/winner";

    if(keystroke.keyCode == 81){
      current_position_1.removeClass('active').next().addClass('active');
    }
    else if(keystroke.keyCode == 80){
      current_position_2.removeClass('active').next().addClass('active');
    }

    if ($('#player1_strip td:last-child').attr('class') == "active"){
      $(document).unbind('keyup');

      $.post(url, {"winner": player1.name}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
    else if ($('#player2_strip td:last-child').attr('class') == "active"){
      $(document).unbind('keyup');
      $.post(url, {"winner": player2.name}, function(response) {
        var new_body = $(response).filter('#result-container');
        $(document).find('#container').html(new_body);
      });
    }
  });
});





function Player(name) {
  this.name = name;
}

function Game() {
  this.winner = "";
}



// function Player () {
//   this.getMethods = function(properties, scope)
//   {
//     var $this = scope;
//     //store classs scope into a var name $this

//     //iterate through the properties of this object
//     for (var i in properties)
//     {
//       (function(i)
//       {
//         // dyanm create an accessor method
//         $this ["get" + i ] = function()
//         {
//           return properties[i];
//         };

//         //dynamically create a mutuation method that parses for an integer 
//         // Ensures that it is positive
//         $this["set" + i ] = function(val)
//         {
//           if(isNan(val))
//           {
//             properties[i] = val;
//           }
//           else
//           {
//             properties[i] = Math.abs(val);
//           }
//         };
//       }) (i);
//     }
//   };
// }
