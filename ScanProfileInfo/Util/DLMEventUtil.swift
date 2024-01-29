//
//  DLMEventUtil.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/19.
//

import Foundation
import EventKit

class DLMEventUtil: ObservableObject {
    private lazy var eventStore = EKEventStore()
    @Published var createdEvent: EKEvent?
    
    
    func createCalendarEvent(with title: String, notes: String, startDate: Date, endDate: Date, alarmDate: Date) {
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted && error == nil {
                if let existEvent = self.getEvent(with: title, notes: notes, startDate: startDate, endDate: endDate, alarmDate: alarmDate) {
                    print("event already exist")
                    // 已存在
                    return
                }
                let event = EKEvent(eventStore: self.eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = notes
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                event.addAlarm(EKAlarm(absoluteDate: alarmDate))
                do {
                    try self.eventStore.save(event, span: .thisEvent)
                    self.createdEvent = event
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
            } else {
                print("failed to save event with error : \(error) or access not granted")
            }
        }
    }
    
    func deleteEvent(by eventId: String) {
        if let eventToDel = eventStore.event(withIdentifier: eventId) {
            do {
                try eventStore.remove(eventToDel, span: .thisEvent)
            } catch let error as NSError {
                print("failed to delete event with error : \(error)")
            }
        }
    }
    
    func getAllEventNextYear() {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate!, calendars: nil)
        let allEvents = eventStore.events(matching: predicate)
    }
    
    func getEventByID(eventId: String) -> EKEvent? {
        return eventStore.event(withIdentifier: eventId)
    }
    
    func getEvent(with title: String, notes: String, startDate: Date, endDate: Date, alarmDate: Date) -> EKEvent? {
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let allEvents = eventStore.events(matching: predicate)
        for event in allEvents {
            if event.title == title && event.notes == notes {
                return event
            }
        }
        return nil
    }
}
