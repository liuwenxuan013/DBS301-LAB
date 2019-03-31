// Assembly Line Project
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.
#ifndef SICT_ITEM_H
#define SICT_ITEM_H

namespace sict {
	class ItemSet {
		std::string name="";
		unsigned int serialNum{0u};
		unsigned int qty{0u};
		std::string desc;
		static size_t width;
	public:
		ItemSet();
		ItemSet(const std::string& str);
		const std::string& getName() const;
		const unsigned int getSerialNumber()const;
		const unsigned int getQuantity()const;
		ItemSet& operator--();
		void display(std::ostream& os, bool) const;
	};

}
#endif
