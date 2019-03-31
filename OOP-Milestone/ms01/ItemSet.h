//
//  ItemSet.h
//  ms
//
//  Created by Wenxuan Liu on 2019-03-06.
//  Copyright © 2019 Wenxuan Liu. All rights reserved.
//

#ifndef ItemSet_h
#define ItemSet_h
#include <iostream>
#include <stdlib.h>
#include <iomanip>
#include "Utilities.h"
namespace sict{
    class ItemSet{
        std::string name;
        unsigned int serialNum;
        unsigned int qty;
        std::string desc;
        static size_t w;
    public:
        ItemSet();
        ItemSet(const std::string& );
        const std::string& getName() const;
        const unsigned int getSerialNumber() const;
        const unsigned int getQuantity() const;
        ItemSet& operator--();
        void display(std::ostream& os, bool full) const;
    };
    
    
}
#endif /* ItemSet_h */
