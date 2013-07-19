var glob = require("glob");
fs = require('fs');
var mysql = require('mysql');
var parseXlsx = require('excel');
var check = require('validator').check;
var sanitize = require('validator').sanitize;

var client = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'root',
	database: 'hoot_quest_development'
});
client.connect();
 function success_callback(code){
  	client.query("UPDATE excels SET status=1 where id="+code+";",
		function(err, results, fields) {
			if (err) throw err;	
						
		}
	); 
 }
  var team_id="";
 function get_team_by_user(user){


  client.query("select team_id from users where id="+user+";",
		function(err, result, field) {
			if (err) throw err;
			
			team_id= result[0].team_id;	
			//console.log("Result team"+user+"vdfsdf" +team_id);		
		}
	); 
	return team_id;
 }

 function error_callback(code, fields){
  	client.query("UPDATE TABLE excels SET status=2 where id="+code+";",
		function(err, results, fields) {
			if (err) throw err;	
						
		} 
    //fs.open(fileName, 'w');

		// for(iterator in fields){

		// }
	); 
 }

 function parse_excell(file,user_id,code){
 	parseXlsx(file, function(err, data) {
    if(err) throw err;
    // data is an array of arrays
   
    for(var index=1; index < data.length; index++ ){
     console.log(data[1]);
     var data1=data[index];
    // if(data[index].length > 0){
        	var team_id;
		 	var first_name= data1[0];
			var middle_name= data1[1];
			var last_name= data1[2];	
			var job_title= data1[3];	
			var email= data1[4];	
			var mobile_phone= data1[5];	
			var home_phone= data1[6];	
			var business_phone= data1[7];	
			var address= data1[9] +","+data1[8];;
			var city= data1[10];
			var state= data1[11];	
			var zip_code= data1[12];	
			var Keywords= data1[13];	
			var notes= data1[14];	
			var referred_by= data1[15];	
			var linked_in= data1[16];	
			var facebook= data1[17];	
			var twitter= data1[18];
			var added_from="Excell File";
			client.query("select team_id from users where id="+user_id+";",
	    	function(err, result, field) {
						if (err) throw err;
						
						team_id= result[0].team_id;	
						//console.log("Result team"+user+"vdfsdf" +team_id);		
					}
				); 
        
        var sql = 'INSERT INTO candidates (first_name, middle_name, last_name, email, address, city, state, zip, contact_number, home_phone, business_phone, team_id, user_id, added_from, linked_in, twitter, facebook, referred_by, position) VALUES ("' + first_name + '","' + middle_name + '","' + last_name + '","' + email + '","' + address + '","' + city + '","' + state+ '","' + zip_code + '","' + mobile_phone + '","' + home_phone + '","' + business_phone + '","' +team_id + '","' +user_id+ '","' + added_from + '","' +linked_in+ '","' +twitter+ '","' + facebook + '","' +referred_by+ '","' +job_title+ '");';
		    try {
					 var isemail=check(email,"invalid Email!").isEmail(); 
					 var ismobile =check(mobile_phone,"Mobile number not valid!").len(10, 13);
					 	 client.query(sql,function(err) {
							  if (err) throw err;	
						    }); 
					 	 success_callback(code);
					} catch (err) {
					    // handle the error safely
					    console.log("ERROR :"+err.message);
					}
		   
		     //}
    }
	});

 }

	client.query("SELECT * FROM excels where status=0;",
		function(err, results, fields) {
			if (err) throw err;
			for (var index in results) {
				var id=results[index].id;
       if(results[index].status==0){
       	console.log(results[index].excel_sheet_file_name);
         var team=get_team_by_user(results[index].user_id);
         console.log("team=="+team);
        parse_excell(results[index].excel_sheet_file_name,results[index].user_id,id);
       }
				
				
			}
			
		}
	); 

// Read the Directory
fs.readdir(process.cwd(), function (err, files) {
  if (err) {
    console.log(err);
    return;
  }
  //console.log(files);
  // find the excell files
 	glob("**/*.xls*",files, function (er, files) {
  	console.log(files);
  	//processing Files

	});// End Of glob

});// End of file stream

