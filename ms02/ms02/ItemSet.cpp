// Assembly Line Project
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.
#include <iostream>
#include <iomanip>
#include <string>
#include "ItemSet.h"
#include "Utilities.h"

namespace sict {
	size_t ItemSet::width= 0u;
	ItemSet::ItemSet(const std::string& str) {
		size_t post=0u;
		Utilities utilities;
		if (!str.empty()) {
			name = utilities.extractToken(str, post);
			if (width< name.length())
					width= name.length();
			std::string temp = utilities.extractToken(str, post);
			serialNum = std::stoi(temp);
            temp= utilities.extractToken(str, post);
			qty = std::stoi(temp);
            desc= utilities.extractToken(str, post);
		}
	}

	const std::string& ItemSet::getName() const {   return name;}
	const unsigned int ItemSet::getSerialNumber() const {   return serialNum;}
	const unsigned int ItemSet::getQuantity() const {   return qty;}
    ItemSet& ItemSet::operator--() {
		if (qty >0) {
			qty--;
			serialNum++;
		}
		return *this;
	}
	void ItemSet::display(std::ostream& os, bool full) const {
        os.setf(std::ios::left);
        os <<std::setw((int)width)<<std::setfill(' ') << name;
        os << " [" << std::setfill('0') << std::setw(5) <<std::right<< serialNum << "] " <<std::setfill(' ');
        if (full) {
            os << "Quantity " <<std::setfill(' ')<< std::setw(3)<<std::left << qty;
            os << " Description: " << desc << std::endl;
        }
	}
}
