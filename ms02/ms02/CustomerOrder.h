// Assembly Line Project
// CustomerOrder.h - 
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.


#ifndef SICT_CUSTOMERORDER_H
#define SICT_CUSTOMERORDER_H
#include<string>
#include <vector>
#include <iostream>
#include "ItemSet.h"
namespace sict {
    struct itemInfo {
        std::string itemName;
        unsigned int serialNum;
        bool filledStatus;
    };
    class CustomerOrder {
        std::string customerName = "";
        std::string productName = "";
    std::vector<itemInfo> Items;
        size_t itemNum;
        static size_t fieldwidth;
    public:
        CustomerOrder();
        CustomerOrder(const std::string& str);
        ~CustomerOrder();
        void fillItem(ItemSet& item, std::ostream& os);
        bool isFilled() const;
        bool isItemFilled(const std::string& item) const;
        std::string getNameProduct() const;
        void display(std::ostream& os, bool showDetail= false) const;
        CustomerOrder(CustomerOrder&&)=default;
        CustomerOrder& operator=(CustomerOrder&&)=default;
        CustomerOrder(CustomerOrder&)= delete;
        CustomerOrder& operator=(CustomerOrder&) = delete;
    };
    
}


#endif
