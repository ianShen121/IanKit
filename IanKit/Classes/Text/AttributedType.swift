//
//  AttributeKeyProvider.swift
//  IanTextKit
//
//  Created by master on 2019/5/16.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation
import UIKit

public enum AttributedType{
    ///字体
    case font(_ font:UIFont)
    ///段落风格
    case paragraphStyle(_ paragrath:NSMutableParagraphStyle)
    ///前景色，也就是文字颜色
    case foregroundColor(_ color:UIColor)
    //背景颜色
    case backgroundColor(_ color:UIColor)
    ///连字功能
    case ligature(_ value:NSNumber)
    ///字间距 NSnumber 正直 加大间距，负值减小间距
    case kern(_ value:NSNumber)
    ///删除线0无1有
    case strikethroughStyle(_ stype:NSUnderlineStyle)
    ///下划线 0无1有
    case underlineStyle(_ stype:NSUnderlineStyle)
    ///描边颜色
    case strokeColor(_ color:UIColor)
    ///描边宽度
    case strokeWidth(_ widht:CGFloat)
    ///阴影
    case shadow(_ shadow:NSShadow)
    ///文字效果
    case textEffect
    ///附件
    case attachment(_ attachment:NSTextAttachment)
    ///链接
    case link(_ url:String)
    ///基线偏移量 正值上偏，负值下偏
    case baselineOffset(_ value:NSNumber) //正值上偏，负值下偏
    ///下划线颜色
    case underlineColor(_ color:UIColor)
    ///删除线颜色
    case strikethroughColor(_ color:UIColor)
    ///倾斜度 正左，负右
    case obliqueness(_ value:NSNumber)
    
    ///字体的伸缩
    case expansion(_ value:NSNumber)
    
    ///书写方向
    case writingDirection(_ d:NSWritingDirection)
    ///文字排版方向
    case verticalGlyphForm(_ isHorizal:Bool)
   
    var attributes:[NSAttributedString.Key:Any]{
        var temp:[NSAttributedString.Key:Any] = [:]
        switch self {
        case .font(let font):
            temp.updateValue(font, forKey: .font)
        case .paragraphStyle(let style):
            temp.updateValue(style, forKey: .paragraphStyle)
        case .backgroundColor(let color):
            temp.updateValue(color, forKey: .backgroundColor)
        case .foregroundColor(let color):
            temp.updateValue(color, forKey: .foregroundColor)
        case .ligature(let value):
            temp.updateValue(value, forKey: .ligature)
        case .kern(let value):
            temp.updateValue(value, forKey: .kern)
        case .underlineStyle(let style):
            temp.updateValue(style.rawValue, forKey: .underlineStyle)
        case .strikethroughStyle(let style):
            temp.updateValue(style.rawValue, forKey: .strikethroughStyle)
        case .strokeColor(let color):
            temp.updateValue(color, forKey: .strokeColor)
        case .strokeWidth(widht: let w):
            temp.updateValue(w, forKey: .strokeWidth)
        case .shadow(let shadow):
            temp.updateValue(shadow, forKey: .shadow)
        case .attachment(let attatch):
            temp.updateValue(attatch, forKey: .attachment)
        case .link(let url):
            temp.updateValue(url, forKey: .link)
        case .baselineOffset(let value):
            temp.updateValue(value, forKey: .baselineOffset)
        case .underlineColor(let color):
            temp.updateValue(color, forKey: .underlineColor)
        case .strikethroughColor(let color):
            temp.updateValue(color, forKey: .strikethroughColor)
        case .obliqueness(let value):
            temp.updateValue(value, forKey: .obliqueness)
        case .expansion(value: let value):
            
            temp.updateValue(value, forKey: .expansion)
        case .writingDirection(let w):
            temp.updateValue(w, forKey: .writingDirection)
        case .verticalGlyphForm(let flag):
            temp.updateValue(flag ? 0 : 1, forKey: .verticalGlyphForm)
        default:
            break
        }
        return temp
        
    }
    
    
    
    
}
