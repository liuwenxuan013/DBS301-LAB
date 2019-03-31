//
//  Utilities.h
//  ms
//
//  Created by Wenxuan Liu on 2019-03-06.
//  Copyright © 2019 Wenxuan Liu. All rights reserved.
//

#ifndef Utilities_h
#define Utilities_h
#include <iostream>
#include <vector>
namespace sict{
    class Utilities{
        static char delimiter;
        size_t fieldWidth;
    public:
        Utilities();
        const std::string extractToken(const std::string& str,size_t& next_pos);
        const char getDelimiter()const;
        size_t getFieldWidth() const ;
        static void setDelimiter(const char d);
        void setFieldWidth(size_t);
        
    };
}


#endif /* Utilities_h */
