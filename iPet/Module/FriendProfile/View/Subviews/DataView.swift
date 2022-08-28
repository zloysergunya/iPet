//
//  DayDataView.swift
//  iPet
//
//  Created by Олейник Богдан on 27.08.2022.
//

import UIKit

class DataView: UIView {

    let stepCount = StateView()
    let distanceCount = StateView()
    
    let averageDistanceCount: StateView = {
        let view = StateView()
        view.stateStackView.alignment = .trailing
        
        return view
    }()
    
    let caloriesCount: StateView = {
        let view = StateView()
        view.stateStackView.alignment = .trailing
        
        return view
    }()
    
    let petImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bigLama")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(stepCount)
        addSubview(distanceCount)
        addSubview(petImage)
        addSubview(averageDistanceCount)
        addSubview(caloriesCount)
        
        stepCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36.0)
            make.left.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        distanceCount.snp.makeConstraints { make in
            make.top.equalTo(stepCount.snp.bottom).offset(13.0)
            make.left.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        petImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(78.0)
            make.height.equalTo(190.0)
        }
        
        averageDistanceCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36.0)
            make.right.equalToSuperview()
            make.width.equalTo(100.0)
        }
        
        caloriesCount.snp.makeConstraints { make in
            make.top.equalTo(averageDistanceCount.snp.bottom).offset(13.0)
            make.right.equalToSuperview()
            make.width.equalTo(100.0)
        }
    }
    
}
