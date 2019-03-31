//
//  Utilities.cpp
//  ms
//
//  Created by Wenxuan Liu on 2019-03-06.
//  Copyright © 2019 Wenxuan Liu. All rights reserved.
//

#include "Utilities.h"
namespace sict{
    char Utilities::delimiter=' ';
    Utilities::Utilities():fieldWidth(0u){};
    const std::string Utilities::extractToken(const std::string& str,size_t& next_pos) {
        size_t current_pos = str.find(delimiter, next_pos);;
        std::string token;
        if (current_pos != std::string::npos) {
            token = str.substr(next_pos, (current_pos - next_pos));
        }
        else
            token = str.substr(next_pos);
        fieldWidth = fieldWidth>token.size()? fieldWidth : token.size();
     if(token.empty())
            throw std::string("No found");
        return token;
    }
    const char Utilities::getDelimiter()const{return delimiter;}
    size_t Utilities::getFieldWidth() const{return fieldWidth;}
    void Utilities::setDelimiter(const char d){delimiter=d;}
    void Utilities::setFieldWidth(size_t w){fieldWidth=w;}
}
