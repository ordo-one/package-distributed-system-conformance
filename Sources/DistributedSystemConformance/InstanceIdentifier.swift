// Copyright 2023 Ordo One AB
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0

import Frostflake

public struct InstanceIdentifier: Hashable, Codable, CustomStringConvertible {
    public let rawValue: FrostflakeIdentifier

    public var description: String {
        String(describing: rawValue)
    }

    public init(_ rawValue: FrostflakeIdentifier = Frostflake.generate()) {
        self.rawValue = rawValue
    }
}
