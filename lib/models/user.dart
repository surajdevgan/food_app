class User
{
int user_id;
String user_name;
String user_email;
String user_province;
String user_gender;
String user_password;

User(
this.user_id,
this.user_name,
this.user_email,
this.user_province,
this.user_gender,
this.user_password,


);

factory User.fromJson(Map<String, dynamic> json) => User(
int.parse(json["user_id"]),
  json["user_name"],
  json["user_email"],
  json["user_province"],
  json["user_gender"],
  json["user_password"],

);


Map<String, dynamic> toJson() =>
    {
     'user_id' : user_id.toString(),
     'user_name' : user_name,
      'user_email' : user_email,
      'user_province' : user_province,
      'user_gender' : user_gender,
      'user_password' : user_password,


    };

}