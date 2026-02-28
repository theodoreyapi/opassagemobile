class RoomsModel {
  int? idRoom;
  String? name;
  int? bedrooms;
  int? bathrooms;
  int? livingRooms;
  int? capacity;
  String? pricePerNight;
  int? isAvailable;
  int? idHotel;
  String? hotelType;
  String? descCourte;
  String? descEtabli;
  String? descHeberge;
  String? latitude;
  String? longitude;
  String? monnaie;
  String? hotelIn;
  String? hotelOut;
  int? freeCancel;
  int? nbreReservation;
  String? rating;
  int? review;
  String? hotelName;
  String? hotelAddress;
  List<Images>? images;
  List<Pricings>? pricings;
  List<Amenities>? amenities;

  RoomsModel(
      {this.idRoom,
        this.name,
        this.bedrooms,
        this.bathrooms,
        this.livingRooms,
        this.capacity,
        this.pricePerNight,
        this.isAvailable,
        this.idHotel,
        this.hotelType,
        this.descCourte,
        this.descEtabli,
        this.descHeberge,
        this.latitude,
        this.longitude,
        this.monnaie,
        this.hotelIn,
        this.hotelOut,
        this.freeCancel,
        this.nbreReservation,
        this.rating,
        this.review,
        this.hotelName,
        this.hotelAddress,
        this.images,
        this.pricings,
        this.amenities});

  RoomsModel.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    name = json['name'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    livingRooms = json['living_rooms'];
    capacity = json['capacity'];
    pricePerNight = json['price_per_night'];
    isAvailable = json['is_available'];
    idHotel = json['id_hotel'];
    hotelType = json['hotel_type'];
    descCourte = json['desc_courte'];
    descEtabli = json['desc_etabli'];
    descHeberge = json['desc_heberge'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    monnaie = json['monnaie'];
    hotelIn = json['hotel_in'];
    hotelOut = json['hotel_out'];
    freeCancel = json['free_cancel'];
    nbreReservation = json['nbre_reservation'];
    rating = json['rating'];
    review = json['review'];
    hotelName = json['hotel_name'];
    hotelAddress = json['hotel_address'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['pricings'] != null) {
      pricings = <Pricings>[];
      json['pricings'].forEach((v) {
        pricings!.add(new Pricings.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_room'] = idRoom;
    data['name'] = name;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['living_rooms'] = livingRooms;
    data['capacity'] = capacity;
    data['price_per_night'] = pricePerNight;
    data['is_available'] = isAvailable;
    data['id_hotel'] = idHotel;
    data['hotel_type'] = hotelType;
    data['desc_courte'] = descCourte;
    data['desc_etabli'] = descEtabli;
    data['desc_heberge'] = descHeberge;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['monnaie'] = monnaie;
    data['hotel_in'] = hotelIn;
    data['hotel_out'] = hotelOut;
    data['free_cancel'] = freeCancel;
    data['nbre_reservation'] = nbreReservation;
    data['rating'] = rating;
    data['review'] = review;
    data['hotel_name'] = hotelName;
    data['hotel_address'] = hotelAddress;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (pricings != null) {
      data['pricings'] = pricings!.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? idImage;
  String? imagePath;
  String? type;
  int? isMain;

  Images({this.idImage, this.imagePath, this.type, this.isMain});

  Images.fromJson(Map<String, dynamic> json) {
    idImage = json['id_image'];
    imagePath = json['image_path'];
    type = json['type'];
    isMain = json['is_main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_image'] = idImage;
    data['image_path'] = imagePath;
    data['type'] = type;
    data['is_main'] = isMain;
    return data;
  }
}

class Pricings {
  int? idPricing;
  String? label;
  int? nights;
  String? price;

  Pricings({this.idPricing, this.label, this.nights, this.price});

  Pricings.fromJson(Map<String, dynamic> json) {
    idPricing = json['id_pricing'];
    label = json['label'];
    nights = json['nights'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pricing'] = idPricing;
    data['label'] = label;
    data['nights'] = nights;
    data['price'] = price;
    return data;
  }
}

class Amenities {
  int? idAmenity;
  String? name;
  String? icon;
  int? available;

  Amenities({this.idAmenity, this.name, this.icon, this.available});

  Amenities.fromJson(Map<String, dynamic> json) {
    idAmenity = json['id_amenity'];
    name = json['name'];
    icon = json['icon'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_amenity'] = idAmenity;
    data['name'] = name;
    data['icon'] = icon;
    data['available'] = available;
    return data;
  }
}