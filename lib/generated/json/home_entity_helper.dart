import 'package:flutter_dio_demo_2/home/model/home_entity.dart';

homeEntityFromJson(HomeEntity data, Map<String, dynamic> json) {
	if (json['bids'] != null) {
		data.bids = (json['bids'] as List).map((v) => HomeBids().fromJson(v)).toList();
	}
	if (json['asks'] != null) {
		data.asks = (json['asks'] as List).map((v) => HomeAsks().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> homeEntityToJson(HomeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bids'] =  entity.bids?.map((v) => v.toJson())?.toList();
	data['asks'] =  entity.asks?.map((v) => v.toJson())?.toList();
	return data;
}

homeBidsFromJson(HomeBids data, Map<String, dynamic> json) {
	if (json['rate'] != null) {
		data.rate = json['rate'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['period'] != null) {
		data.period = json['period'] is String
				? int.tryParse(json['period'])
				: json['period'].toInt();
	}
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp'].toString();
	}
	if (json['frr'] != null) {
		data.frr = json['frr'].toString();
	}
	return data;
}

Map<String, dynamic> homeBidsToJson(HomeBids entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rate'] = entity.rate;
	data['amount'] = entity.amount;
	data['period'] = entity.period;
	data['timestamp'] = entity.timestamp;
	data['frr'] = entity.frr;
	return data;
}

homeAsksFromJson(HomeAsks data, Map<String, dynamic> json) {
	if (json['rate'] != null) {
		data.rate = json['rate'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['period'] != null) {
		data.period = json['period'] is String
				? int.tryParse(json['period'])
				: json['period'].toInt();
	}
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp'].toString();
	}
	if (json['frr'] != null) {
		data.frr = json['frr'].toString();
	}
	return data;
}

Map<String, dynamic> homeAsksToJson(HomeAsks entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rate'] = entity.rate;
	data['amount'] = entity.amount;
	data['period'] = entity.period;
	data['timestamp'] = entity.timestamp;
	data['frr'] = entity.frr;
	return data;
}