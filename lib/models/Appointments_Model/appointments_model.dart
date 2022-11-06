class AppointmentModel{
 String created_at;
 String deleted_at;
 String email;
 String end_date;
 String end_time;
 String id;
 String name;
 String reason;
 String start_date;
 String start_time;
 int status;
 String updated_at;
 String appointment_Status;
 int sortingid;

 AppointmentModel({
      required this.created_at,
      required this.deleted_at,
      required this.email,
      required this.end_date,
      required this.end_time,
      required this.id,
      required this.name,
      required this.reason,
      required this.start_date,
      required this.start_time,
      required this.status,
      required this.updated_at,
      required this.appointment_Status,
      required this.sortingid,

 });




factory AppointmentModel.fromJson(Map<String, dynamic> json)=>
    AppointmentModel(
      id:json['id'],
      name:json['name'],
      email:json['email'],
      reason:json['reason'],
      status:json['status'],
      created_at:json['created_at'],
      deleted_at:json['deleted_at'],
      end_date:json['end_date'],
      end_time:json['end_time'],
      start_date:json['start_date'],
      start_time:json['start_time'],
      updated_at:json['updated_at'],
      appointment_Status: json['appointment_Status'],
      sortingid: json['sortingid']



    );

 Map<String, dynamic> toJson() => {
   'id':id,
   'name':name,
   'email':email,
   'reason':reason,
   'status':status,
   'created_at':created_at,
   'deleted_at':deleted_at,
   'end_date':end_date,
   'end_time':end_time,
   'start_date':start_date,
   'start_time':start_time,
   'updated_at':updated_at,
   'appointment_Status':appointment_Status,
   'sortingid':sortingid,

 };


}