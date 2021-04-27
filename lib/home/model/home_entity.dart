import 'package:flutter_dio_demo_2/generated/json/base/json_convert_content.dart';

class HomeEntity with JsonConvert<HomeEntity> {
	List<HomeBids> bids;
	List<HomeAsks> asks;
}

class HomeBids with JsonConvert<HomeBids> {
	String rate;
	String amount;
	int period;
	String timestamp;
	String frr;
}

class HomeAsks with JsonConvert<HomeAsks> {
	String rate;
	String amount;
	int period;
	String timestamp;
	String frr;
}
