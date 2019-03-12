//
//  ItemSet.cpp
//  ms
//
//  Created by Wenxuan Liu on 2019-03-06.
//  Copyright © 2019 Wenxuan Liu. All rights reserved.
//

#include "ItemSet.h"
namespace sict{
    size_t ItemSet::w=0u;
    ItemSet::ItemSet():name{nullptr},serialNum{0},qty{0},desc{nullptr}{};
    ItemSet::ItemSet(const std::string& str){
        size_t pos=0u;
        Utilities u;
        name= u.extractToken(str,pos);
        w=name.length()<w ? w:name.length();
        pos=name.length()+1;
        serialNum = std::stoi(u.extractToken(str,pos));
        pos+=(u.extractToken(str,pos)).length()+1;
        qty =std::stoi(u.extractToken(str,pos));
        pos+=(u.extractToken(str,pos)).length()+1;
        desc =u.extractToken(str,pos);
       
    }
    const std::string& ItemSet::getName() const{return name;}
    const unsigned int ItemSet::getSerialNumber() const{return serialNum;}
    const unsigned int ItemSet::getQuantity() const{return qty;}
    ItemSet& ItemSet::operator--(){
        qty--;
        serialNum++;
        return *this;
    }
    void ItemSet::display(std::ostream& os, bool full) const{
            os.setf(std::ios::left);
            os<<std::setw(w)<<name;
            os.unsetf(std::ios::left);
            os<<" ["<<std::setfill('0')<<std::setw(6)<<serialNum<<"]"<<std::setfill(' ');
          if(full){
            os.setf(std::ios::left);
            os<<" Quantity "<<std::setw(3)<<qty;
            os.unsetf(std::ios::left);
            os<<" Description: "<<desc<<std::endl;
        }
    }
        
    
}













