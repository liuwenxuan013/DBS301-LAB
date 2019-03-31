// Assembly Line Project
// CustomerOrder.cpp
//  Created by Liu Wenxuan on 2019-03-20.
//  Copyright © 2019 Liu Wenxuan. All rights reserved.

#include <iomanip>
#include "Utilities.h"
#include "ItemSet.h"
#include"CustomerOrder.h"

namespace sict {
    
    size_t CustomerOrder::fieldwidth=0u;
    CustomerOrder::CustomerOrder() {}
    CustomerOrder::CustomerOrder(const std::string& str) {
        try {
            size_t post = 0u;
            Utilities utilities;
            if (!str.empty()) {
                customerName = utilities.extractToken(str, post);
                if (fieldwidth < utilities.getFieldWidth())
                    fieldwidth = utilities.getFieldWidth();
                productName = utilities.extractToken(str, post);
                std::vector<std::string> order;
                while (post < str.length() ) {
                    order.push_back(utilities.extractToken(str, post));
                }
                itemNum = order.size();
                std::vector<std::string>::const_iterator i;
                for (i = order.begin();i != order.end();i++)
                    Items.push_back({ .itemName = *i, .serialNum = 0, .filledStatus = false });
//            while (post < str.length() ){//post != std::string::npos &&
//                    Items.push_back((itemInfo){
//                        .itemName = utilities.extractToken(str, post),
//                        .filledStatus = false,
//                        .serialNum=0
//                    });
//                    itemNum++;
//                }
            }
        }
        catch (const std::string& msg) {    std::cerr << msg << std::endl;}
    }
    CustomerOrder::~CustomerOrder() {}
    void CustomerOrder::fillItem(ItemSet& item, std::ostream& os) {
        for (size_t i = 0; i < itemNum; i++) {
            if (Items[i].itemName == item.getName()) {
                if (item.getQuantity() < 1) {
                    Items[i].serialNum = item.getSerialNumber();
                    os << " Unable to fill " << this->customerName << "[" << this->getNameProduct() << "]["
                    << Items[i].itemName << "][" << this->Items[i].serialNum << "]" << " out of stock" <<std::endl;
                }
                else if (Items[i].filledStatus) {
                    Items[i].serialNum = item.getSerialNumber();
                    os << " Unable to fill " << this->customerName << "[" << this->getNameProduct() << "]["
                    << Items[i].itemName << "][" << Items[i].serialNum << "]" << " already filled" <<std::endl;
                }
                else {
                   Items[i].filledStatus = true;
                    --item;
                  Items[i].serialNum = item.getSerialNumber();
                    os << " Filled " << customerName << "[" << getNameProduct() << "]["
                    << Items[i].itemName << "][" << Items[i].serialNum << "]" << std::endl;
                    
                }
            }
        }
        
    }
    bool CustomerOrder::isFilled() const {
        bool fill = true;
        for (size_t i = 0; i < itemNum; i++) {
            if (!Items[i].filledStatus)
                fill = false;
        }
        return fill;
    }
    
    bool CustomerOrder::isItemFilled(const std::string& item) const {
        bool itemfilled = true;
        for (size_t i = 0; i < itemNum; i++)
            if (Items[i].itemName == item && !Items[i].filledStatus)
                itemfilled = false;
        return itemfilled;
    }
    
    std::string CustomerOrder::getNameProduct() const { return   productName;}
    void CustomerOrder::display(std::ostream& os, bool showDetail) const {
        os << std::setw((int)CustomerOrder::fieldwidth)<< customerName;
        os << "["<< productName << "]" <<std::endl;
        if (showDetail) {
            for (size_t i = 0; i <itemNum; i++) {
                std::string status = (Items[i].filledStatus) ? "Filled" : "Not Filled";
                os << std::setw((int)CustomerOrder::fieldwidth) << " "
                << "[" << Items[i].serialNum << "]" <<Items[i].itemName
                << "-" <<status << std::endl;
            }
        }else {
            for (size_t i = 0; i <itemNum; i++)
                os << std::setw((int)CustomerOrder::fieldwidth) << " " << Items[i].itemName << std::endl;
        }
    }
}
