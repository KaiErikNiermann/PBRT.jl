Core.vo Core.glob Core.v.beautified Core.required_vo: Core.v 
Core.vio: Core.v 
Core.vos Core.vok Core.required_vos: Core.v 
proofs2.vo proofs2.glob proofs2.v.beautified proofs2.required_vo: proofs2.v Core.vo
proofs2.vio: proofs2.v Core.vio
proofs2.vos proofs2.vok proofs2.required_vos: proofs2.v Core.vos
proofs.vo proofs.glob proofs.v.beautified proofs.required_vo: proofs.v 
proofs.vio: proofs.v 
proofs.vos proofs.vok proofs.required_vos: proofs.v 
Data.vo Data.glob Data.v.beautified Data.required_vo: Data.v Core.vo
Data.vio: Data.v Core.vio
Data.vos Data.vok Data.required_vos: Data.v Core.vos
Tactics.vo Tactics.glob Tactics.v.beautified Tactics.required_vo: Tactics.v Data.vo Core.vo
Tactics.vio: Tactics.v Data.vio Core.vio
Tactics.vos Tactics.vok Tactics.required_vos: Tactics.v Data.vos Core.vos
Record.vo Record.glob Record.v.beautified Record.required_vo: Record.v Core.vo Data.vo
Record.vio: Record.v Core.vio Data.vio
Record.vos Record.vok Record.required_vos: Record.v Core.vos Data.vos
