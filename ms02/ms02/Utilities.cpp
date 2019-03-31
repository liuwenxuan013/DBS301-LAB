// Assembly Line Project
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.
#include "Utilities.h"

namespace sict {

	char Utilities::delimiter = '|';
	Utilities::Utilities():fieldwidth(0){}
	const std::string Utilities::extractToken(const std::string& str, size_t& next_pos) {
		std::string token;
		if (next_pos <= str.length()) {
			size_t pos = next_pos;
			next_pos = str.find(delimiter, pos);
			if (next_pos !=std::string::npos) {
				token = str.substr(pos, next_pos - pos);
				next_pos++;
			}
			else {
				token = str.substr(pos);
				next_pos = str.length() + 1;
			}
		}
		if (token.length() > fieldwidth)
			fieldwidth = token.length();
		if (token.empty() && next_pos != str.length() + 1) {
			next_pos = std::string::npos;
			throw "not found token";
		}
		return token;
	}
	const char Utilities::getDelimiter() const {    return delimiter;}
	size_t Utilities::getFieldWidth() const {   return fieldwidth;}
	void Utilities::setDelimiter(const char d) {    delimiter = d;}
	void Utilities::setFieldWidth(size_t t) {   fieldwidth = t;}
}
