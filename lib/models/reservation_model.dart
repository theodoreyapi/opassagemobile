class ReservationModel {
  int? idReservation;
  int? userId;
  int? roomId;
  String? startDate;
  String? endDate;
  String? totalPrice;
  String? status;
  String? createdAt;
  String? updatedAt;
  Room? room;
  List<Payments>? payments;
  Promo? promo;

  ReservationModel({
    this.idReservation,
    this.userId,
    this.roomId,
    this.startDate,
    this.endDate,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.room,
    this.payments,
    this.promo,
  });

  ReservationModel.fromJson(Map<String, dynamic> json) {
    idReservation = json['id_reservation'];
    userId = json['user_id'];
    roomId = json['room_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalPrice = json['total_price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
    promo = (json['promo'] != null && json['promo'] is Map<String, dynamic>)
        ? Promo.fromJson(json['promo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_reservation'] = idReservation;
    data['user_id'] = userId;
    data['room_id'] = roomId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    if (promo != null) {
      data['promo'] = promo!.toJson();
    }
    return data;
  }
}

class Room {
  int? idRoom;
  int? hotelId;
  String? name;
  int? capacity;
  String? pricePerNight;
  Hotel? hotel;
  String? firstImage;

  Room({
    this.idRoom,
    this.hotelId,
    this.name,
    this.capacity,
    this.pricePerNight,
    this.hotel,
    this.firstImage,
  });

  Room.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    hotelId = json['hotel_id'];
    name = json['name'];
    capacity = json['capacity'];
    pricePerNight = json['price_per_night'];
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;
    firstImage = json['first_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_room'] = idRoom;
    data['hotel_id'] = hotelId;
    data['name'] = name;
    data['capacity'] = capacity;
    data['price_per_night'] = pricePerNight;
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    data['first_image'] = firstImage;
    return data;
  }
}

class Hotel {
  int? idHotel;
  String? hotelName;
  String? type;
  String? address;
  String? rating;
  String? image;
  String? latitude;
  String? longitude;
  String? pricePerNight;
  String? currency;
  String? checkInTime;
  String? checkOutTime;
  int? freeCancellationHours;

  Hotel({
    this.idHotel,
    this.hotelName,
    this.type,
    this.address,
    this.rating,
    this.image,
    this.latitude,
    this.longitude,
    this.pricePerNight,
    this.currency,
    this.checkInTime,
    this.checkOutTime,
    this.freeCancellationHours,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    idHotel = json['id_hotel'];
    hotelName = json['hotel_name'];
    type = json['type'];
    address = json['address'];
    rating = json['rating'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pricePerNight = json['price_per_night'];
    currency = json['currency'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    freeCancellationHours = json['free_cancellation_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_hotel'] = idHotel;
    data['hotel_name'] = hotelName;
    data['type'] = type;
    data['address'] = address;
    data['rating'] = rating;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['price_per_night'] = pricePerNight;
    data['currency'] = currency;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['free_cancellation_hours'] = freeCancellationHours;
    return data;
  }
}

class Payments {
  int? idPayment;
  String? amount;
  String? method;
  String? paymentMethod;
  String? status;
  String? transactionId;
  String? createdAt;
  String? reste;
  String? avance;

  Payments({
    this.idPayment,
    this.amount,
    this.method,
    this.paymentMethod,
    this.status,
    this.transactionId,
    this.createdAt,
    this.reste,
    this.avance,
  });

  Payments.fromJson(Map<String, dynamic> json) {
    idPayment = json['id_payment'];
    amount = json['amount'];
    method = json['method'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    reste = json['reste'];
    avance = json['avance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_payment'] = idPayment;
    data['amount'] = amount;
    data['method'] = method;
    data['payment_method'] = paymentMethod;
    data['status'] = status;
    data['transaction_id'] = transactionId;
    data['created_at'] = createdAt;
    data['reste'] = reste;
    data['avance'] = avance;
    return data;
  }
}

class Promo {
  String? code;
  String? discountType;
  int? discountValue;

  Promo({this.code, this.discountType, this.discountValue});

  Promo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    return data;
  }
}
