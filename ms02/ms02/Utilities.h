// Assembly Line Project
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.
#include <fstream>
#include <string>
#include <sstream>

#ifndef SICT_UTI_H
#define SICT_UTI_H
namespace sict {
	class Utilities {
		size_t fieldwidth;
		static char delimiter;
	public:
		Utilities();
		const std::string extractToken(const std::string& str, size_t& next_pos);
		const char getDelimiter() const;
		size_t getFieldWidth() const;
		static void setDelimiter(const char d);
		void setFieldWidth(size_t);
	};
}
#endif
