class DrAppointmentModel {
  DrAppointmentModel({
    required this.created_at,
    required this.deleted_at,
   
    required this.id,
    this.name, this.image, this.end_date, 
    this.end_time,this.start_date, this.start_time, this.status, this.email, this.reason, this.appointment_Status
  });
  String created_at;
  String deleted_at;
  
  String id;
  String? name;
  String? image;
  String? end_date;
  String? end_time;
  
  String? start_date;
  String? start_time;
  String? status;
  String? email;
  String? reason, appointment_Status;
  factory DrAppointmentModel.fromJson(Map<String, dynamic> json) => DrAppointmentModel(
        created_at: json["created_at"],
        deleted_at: json["deleted_at"],
        
        id: json["id"],
        name: json['name'], 
        image:json['imgurl'], end_date: json['end_date'],
        end_time:json['end_time'], 
        
        start_date: json['start_date'],
        start_time: json['start_time'],
        status: json['status'],
        email: json['email'],
        reason:json['reason'], appointment_Status: json['appointment_Status']
      );
  Map<String, dynamic> toJson() => {
        "created_at": created_at,
        "deleted_at": deleted_at,
        'name':name,
        "id": id,
        
        'imgurl':image, 
        'end_date': end_date,
        'end_time':end_time,
       
        'start_date':start_date,
        'start_time': start_time,
        'status': status,
        'email':email,
        'reason':reason,
        'appointment_Status': appointment_Status
      };
}