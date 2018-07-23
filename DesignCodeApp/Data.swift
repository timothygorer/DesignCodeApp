//
//  Data.swift
//  DesignCodeApp
//
//  Created by Tim Gorer on 12/17/17.
//  Copyright © 2017 Tim Gorer. All rights reserved.
//

import UIKit

let benefits : Array<Dictionary<String,String>> = [
    [
        "subhead": "Watch and follow",
        "title": "44 hours of video",
        "body": "Each section is accompanied with captioned, well-paced videos that will help you follow step by step.",
        "image": "Video"
    ],[
        "subhead": "Search and Bookmark",
        "title": "100,000 words",
        "body": "Most online courses either only have texts or videos. Design+Code has both, all searchable.",
        "image": "Words"
    ],[
        "subhead": "Download",
        "title": "10GB Source Files",
        "body": "Over 36 Sketch files, 36 Xcode project files and templates to ensure that you start strong.",
        "image": "Files"
    ],[
        "subhead": "Enjoy Anywhere",
        "title": "iPhone, iPad & Web",
        "body": "Experience the book from your iPhone, iPad and desktop. We got downloadable ePubs too.",
        "image": "iOS"
    ],[
        "subhead": "Read, Browse",
        "title": "Offline Experience",
        "body": "Poor wifi? The app was designed for offline use so that you don't always rely on the internet.",
        "image": "Offline"
    ],[
        "subhead": "Test your Knowledge",
        "title": "Exercises",
        "body": "The questions are hard. Try as many times as you want, get timed and stats to see how you improve.",
        "image": "Exercises"
    ],
]

let exercises = [
    "chapter-1-iOS-11-Design": [
        [
            "question": "What are the 3 core philosophies for iOS design?",
            "correctAnswer": "Deference, clarity and depth",
            "answers": [
                "Intuition, clarity and beauty",
                "Deference, clarity and depth",
                "Fun, clarity and perception",
                "Good, great and insanely great",
                "Clarity, depth and intuition",
            ]
        ],
        [
            "question": "What is the recommended line-height for readability?",
            "correctAnswer": "120% to 145%",
            "answers": [
                "100% to 110%",
                "110% to 120%",
                "110% to 150%",
                "120% to 145%",
                "100% to 160%",
            ],
        ],
    ],
    "chapter-1-Sketch": [
        [
            "question": "What's the big feature in Sketch 47?",
            "correctAnswer": "Libraries",
            "answers": [
                "New Emojis",
                "Nested Symbols",
                "Symbol Overrides",
                "Resizing Constraints",
                "Libraries",
            ]
        ],
    ],
]

let testimonials = [
    [
        "text": "Design+Code is a wake-up call. Why should I learn a web based technology or a deprecated tool when the obvious choice is to learn Xcode?",
        "name": "Jean-Marc Denis",
        "job": "Product Designer at Facebook",
        "avatar": "avatar-jean-marc"
    ],
    [
        "text": "If you're comfortable with Framer, you can easily transfer your knowledge to Swift. You can animate pretty easily while building an app.",
        "name": "Min-Sang Choi",
        "job": "Interaction Designer at Google",
        "avatar": "avatar-min-sang"
    ],
    [
        "text": "First of all I am 12 years old, live in Britain and I just realised that all I want to do for the rest of my life is design amazing things. (Tom Fox won a scolarship for WWDC 2015)",
        "name": "Tom Fox",
        "job": "Student",
        "avatar": "avatar-tom-fox"
    ],
    [
        "text": "As a developer, I really appreciated the chapters on Color Theory and Typography. It was just the right balance of theory combined with practical examples.",
        "name": "Chris Ching",
        "job": "Teaches iOS Programming",
        "avatar": "avatar-chris-ching"
    ],
    [
        "text": "I began a Swift learning plan 5 days ago, this is part of what I did in five days. I learned a lot from Tim Gorer's Design+Code.",
        "name": "MartinRGB",
        "job": "Designer and Coder",
        "avatar": "avatar-martin-rgb"
    ],
    [
        "text": "Thanks to Design + Code, I just released my first app on the store: Sky Graph. It's been a great learning experience as a designer learning to code.",
        "name": "Wayne Sang",
        "job": "Senior Product Manager at TWG",
        "avatar": "avatar-wayne-sang"
    ],
    [
        "text": "I found and bought Design+Code by Tim Gorer which takes you through each step of the process from design to code to app store submission.",
        "name": "Kenny Chen",
        "job": "User Experience Designer at Bankrate",
        "avatar": "avatar-kenny-chen"
    ],
    [
        "text": "Thanks to @TimGorer, I was able to get a rough prototype of my first app working this weekend.",
        "name": "Andrew McCarthy",
        "job": "Product Designer",
        "avatar": "avatar-andrew-mccarthy"
    ]
]
